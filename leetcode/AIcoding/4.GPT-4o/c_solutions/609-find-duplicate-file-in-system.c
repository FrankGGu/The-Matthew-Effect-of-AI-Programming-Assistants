#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>

#define MAX_FILES 10000
#define MAX_PATH 1024

typedef struct {
    char *content;
    char **paths;
    int path_count;
} FileContent;

typedef struct {
    FileContent *files;
    int count;
} FileMap;

FileMap fileMap;

void initFileMap() {
    fileMap.files = (FileContent *)malloc(MAX_FILES * sizeof(FileContent));
    fileMap.count = 0;
}

void addFile(char *content, char *path) {
    for (int i = 0; i < fileMap.count; i++) {
        if (strcmp(fileMap.files[i].content, content) == 0) {
            fileMap.files[i].paths[fileMap.files[i].path_count++] = path;
            return;
        }
    }
    fileMap.files[fileMap.count].content = content;
    fileMap.files[fileMap.count].paths = (char **)malloc(MAX_FILES * sizeof(char *));
    fileMap.files[fileMap.count].paths[0] = path;
    fileMap.files[fileMap.count].path_count = 1;
    fileMap.count++;
}

void searchFiles(char *path) {
    DIR *dir = opendir(path);
    struct dirent *entry;

    if (!dir) return;

    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_DIR) {
            if (strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {
                char newPath[MAX_PATH];
                snprintf(newPath, sizeof(newPath), "%s/%s", path, entry->d_name);
                searchFiles(newPath);
            }
        } else if (entry->d_type == DT_REG) {
            char filePath[MAX_PATH];
            snprintf(filePath, sizeof(filePath), "%s/%s", path, entry->d_name);
            int fd = open(filePath, O_RDONLY);
            if (fd < 0) continue;

            struct stat st;
            fstat(fd, &st);
            char *content = (char *)malloc(st.st_size + 1);
            read(fd, content, st.st_size);
            content[st.st_size] = '\0';
            close(fd);

            addFile(content, filePath);
        }
    }
    closedir(dir);
}

char ***findDuplicate(char **paths, int pathsSize, int *returnSize, int **returnColumnSizes) {
    initFileMap();
    for (int i = 0; i < pathsSize; i++) {
        searchFiles(paths[i]);
    }

    *returnSize = 0;
    for (int i = 0; i < fileMap.count; i++) {
        if (fileMap.files[i].path_count > 1) {
            (*returnSize)++;
        }
    }

    char ***result = (char ***)malloc((*returnSize) * sizeof(char **));
    *returnColumnSizes = (int *)malloc((*returnSize) * sizeof(int));

    int index = 0;
    for (int i = 0; i < fileMap.count; i++) {
        if (fileMap.files[i].path_count > 1) {
            result[index] = fileMap.files[i].paths;
            (*returnColumnSizes)[index] = fileMap.files[i].path_count;
            index++;
        }
    }

    return result;
}