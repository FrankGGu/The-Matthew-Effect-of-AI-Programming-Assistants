#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char *name;
    int count;
} Atom;

typedef struct {
    Atom *atoms;
    int size;
    int capacity;
} AtomMap;

AtomMap *create_atom_map() {
    AtomMap *map = (AtomMap *)malloc(sizeof(AtomMap));
    map->size = 0;
    map->capacity = 4;
    map->atoms = (Atom *)malloc(map->capacity * sizeof(Atom));
    return map;
}

void free_atom_map(AtomMap *map) {
    for (int i = 0; i < map->size; i++) {
        free(map->atoms[i].name);
    }
    free(map->atoms);
    free(map);
}

void add_atom(AtomMap *map, const char *name, int count) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->atoms[i].name, name) == 0) {
            map->atoms[i].count += count;
            return;
        }
    }
    if (map->size >= map->capacity) {
        map->capacity *= 2;
        map->atoms = (Atom *)realloc(map->atoms, map->capacity * sizeof(Atom));
    }
    map->atoms[map->size].name = strdup(name);
    map->atoms[map->size].count = count;
    map->size++;
}

char *format_result(AtomMap *map) {
    char **sorted_names = (char **)malloc(map->size * sizeof(char *));
    for (int i = 0; i < map->size; i++) {
        sorted_names[i] = map->atoms[i].name;
    }
    for (int i = 0; i < map->size - 1; i++) {
        for (int j = i + 1; j < map->size; j++) {
            if (strcmp(sorted_names[i], sorted_names[j]) > 0) {
                char *tmp = sorted_names[i];
                sorted_names[i] = sorted_names[j];
                sorted_names[j] = tmp;
            }
        }
    }

    int result_len = 0;
    for (int i = 0; i < map->size; i++) {
        result_len += strlen(sorted_names[i]) + 2;
        if (map->atoms[i].count > 1) {
            result_len += 2;
        }
    }

    char *result = (char *)malloc(result_len + 1);
    result[0] = '\0';

    for (int i = 0; i < map->size; i++) {
        char count_str[16];
        sprintf(count_str, "%d", map->atoms[i].count);
        if (map->atoms[i].count > 1) {
            strcat(result, sorted_names[i]);
            strcat(result, count_str);
        } else {
            strcat(result, sorted_names[i]);
        }
        if (i != map->size - 1) {
            strcat(result, ",");
        }
    }

    free(sorted_names);
    return result;
}

char *parse_expression(char *expression) {
    int len = strlen(expression);
    int stack_size = 0;
    AtomMap **stack = (AtomMap **)malloc(10 * sizeof(AtomMap *));
    stack[stack_size++] = create_atom_map();

    int i = 0;
    while (i < len) {
        if (expression[i] == '(') {
            stack[stack_size++] = create_atom_map();
            i++;
        } else if (expression[i] == ')') {
            i++;
            int num = 0;
            while (i < len && isdigit(expression[i])) {
                num = num * 10 + (expression[i] - '0');
                i++;
            }
            num = num == 0 ? 1 : num;

            AtomMap *top = stack[--stack_size];
            AtomMap *parent = stack[stack_size - 1];

            for (int j = 0; j < top->size; j++) {
                add_atom(parent, top->atoms[j].name, top->atoms[j].count * num);
            }

            free_atom_map(top);
        } else if (isupper(expression[i])) {
            int j = i + 1;
            while (j < len && islower(expression[j])) {
                j++;
            }
            char *atom_name = (char *)malloc(j - i + 1);
            strncpy(atom_name, &expression[i], j - i);
            atom_name[j - i] = '\0';
            i = j;

            int count = 0;
            while (i < len && isdigit(expression[i])) {
                count = count * 10 + (expression[i] - '0');
                i++;
            }
            count = count == 0 ? 1 : count;

            add_atom(stack[stack_size - 1], atom_name, count);
            free(atom_name);
        } else {
            i++;
        }
    }

    char *result = format_result(stack[0]);
    for (int i = 0; i < stack_size; i++) {
        free_atom_map(stack[i]);
    }
    free(stack);
    return result;
}

char* countOfAtoms(char* expression) {
    return parse_expression(expression);
}