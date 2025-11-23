#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For strcmp

typedef struct {
    char* creator;
    char* videoId;
    int views;
} VideoEntry;

int compareVideoEntries(const void* a, const void* b) {
    VideoEntry* va = (VideoEntry*)a;
    VideoEntry* vb = (VideoEntry*)b;
    return strcmp(va->creator, vb->creator);
}

typedef struct {
    char* creatorName;
    long long totalViews;
    long long maxVideoViews;
    char* maxVideoId;        // Points to the videoId string from original input
} CreatorSummary;

char** mostPopularCreator(char** creators, int creatorsSize, char** videoIds, int videoIdsSize, int* views, int viewsSize, int* returnSize) {
    // Handle empty input case
    if (creatorsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    // 1. Combine inputs into an array of VideoEntry structs
    VideoEntry* videoEntries = (VideoEntry*)malloc(creatorsSize * sizeof(VideoEntry));
    if (!videoEntries) {
        *returnSize = 0;
        return NULL; // Memory allocation failed
    }

    for (int i = 0; i < creatorsSize; i++) {
        videoEntries[i].creator = creators[i];
        videoEntries[i].videoId = videoIds[i];
        videoEntries[i].views = views[i];
    }

    // 2. Sort the video entries by creator name
    qsort(videoEntries, creatorsSize, sizeof(VideoEntry), compareVideoEntries);

    // 3. Process sorted entries to create CreatorSummary structs
    // Max possible unique creators is creatorsSize
    CreatorSummary* creatorSummaries = (CreatorSummary*)malloc(creatorsSize * sizeof(CreatorSummary));
    if (!creatorSummaries) {
        free(videoEntries);
        *returnSize = 0;
        return NULL; // Memory allocation failed
    }
    int numUniqueCreators = 0;
    long long maxOverallTotalViews = 0;

    long long currentCreatorTotalViews = 0;
    long long currentCreatorMaxVideoViews = -1; // Initialize to -1 to ensure any valid view count (>=0) updates it
    char* currentCreatorMaxVideoId = NULL;

    for (int i = 0; i < creatorsSize; i++) {
        // If it's the first video or creator changes
        if (i == 0 || strcmp(videoEntries[i].creator, videoEntries[i-1].creator) != 0) {
            // If not the very first video, save summary for previous creator
            if (i > 0) {
                creatorSummaries[numUniqueCreators].creatorName = videoEntries[i-1].creator; // Any video from this creator will do for name
                creatorSummaries[numUniqueCreators].totalViews = currentCreatorTotalViews;
                creatorSummaries[numUniqueCreators].maxVideoViews = currentCreatorMaxVideoViews;
                creatorSummaries[numUniqueCreators].maxVideoId = currentCreatorMaxVideoId;

                // Update overall max views after processing a creator
                if (currentCreatorTotalViews > maxOverallTotalViews) {
                    maxOverallTotalViews = currentCreatorTotalViews;
                }
                numUniqueCreators++;
            }
            // Reset for new creator
            currentCreatorTotalViews = 0;
            currentCreatorMaxVideoViews = -1;
            currentCreatorMaxVideoId = NULL;
        }

        // Update for current video
        currentCreatorTotalViews += videoEntries[i].views;

        if (videoEntries[i].views > currentCreatorMaxVideoViews) {
            currentCreatorMaxVideoViews = videoEntries[i].views;
            currentCreatorMaxVideoId = videoEntries[i].videoId;
        } else if (videoEntries[i].views == currentCreatorMaxVideoViews) {
            // Lexicographical comparison for videoId if views are equal
            if (strcmp(videoEntries[i].videoId, currentCreatorMaxVideoId) < 0) {
                currentCreatorMaxVideoId = videoEntries[i].videoId;
            }
        }
    }
    // Save summary for the last creator after the loop finishes
    creatorSummaries[numUniqueCreators].creatorName = videoEntries[creatorsSize-1].creator;
    creatorSummaries[numUniqueCreators].totalViews = currentCreatorTotalViews;
    creatorSummaries[numUniqueCreators].maxVideoViews = currentCreatorMaxVideoViews;
    creatorSummaries[numUniqueCreators].maxVideoId = currentCreatorMaxVideoId;

    // Update overall max views for the last creator
    if (currentCreatorTotalViews > maxOverallTotalViews) {
        maxOverallTotalViews = currentCreatorTotalViews;
    }
    numUniqueCreators++;

    // 4. Collect videoIds of creators with maxOverallTotalViews
    // The result array might be smaller than numUniqueCreators if not all creators have max views
    char** result = (char**)malloc(numUniqueCreators * sizeof(char*)); 
    if (!result) {
        free(videoEntries);
        free(creatorSummaries);
        *returnSize = 0;
        return NULL; // Memory allocation failed
    }
    int resultCount = 0;

    for (int i = 0; i < numUniqueCreators; i++) {
        if (creatorSummaries[i].totalViews == maxOverallTotalViews) {
            result[resultCount++] = creatorSummaries[i].maxVideoId;
        }
    }

    *returnSize = resultCount;

    // Free temporary allocations
    free(videoEntries);
    free(creatorSummaries);

    return result;
}