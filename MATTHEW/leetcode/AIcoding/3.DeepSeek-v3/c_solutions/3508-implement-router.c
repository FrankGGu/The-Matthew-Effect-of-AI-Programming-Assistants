typedef struct {
    char** routes;
    char** handlers;
    int capacity;
    int size;
} Router;

Router* routerCreate() {
    Router* obj = (Router*)malloc(sizeof(Router));
    obj->capacity = 100;
    obj->size = 0;
    obj->routes = (char**)malloc(sizeof(char*) * obj->capacity);
    obj->handlers = (char**)malloc(sizeof(char*) * obj->capacity);
    return obj;
}

void routerAddRoute(Router* obj, char * route, char * handler) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->routes = (char**)realloc(obj->routes, sizeof(char*) * obj->capacity);
        obj->handlers = (char**)realloc(obj->handlers, sizeof(char*) * obj->capacity);
    }
    obj->routes[obj->size] = (char*)malloc(strlen(route) + 1);
    strcpy(obj->routes[obj->size], route);
    obj->handlers[obj->size] = (char*)malloc(strlen(handler) + 1);
    strcpy(obj->handlers[obj->size], handler);
    obj->size++;
}

char * routerRoute(Router* obj, char * path) {
    for (int i = 0; i < obj->size; i++) {
        char* route = obj->routes[i];
        char* handler = obj->handlers[i];
        char* r = route;
        char* p = path;

        while (*r && *p) {
            if (*r == '{') {
                while (*r && *r != '}') r++;
                r++;
                while (*p && *p != '/') p++;
            } else if (*r == *p) {
                r++;
                p++;
            } else {
                break;
            }
        }

        if (*r == '\0' && *p == '\0') {
            return handler;
        }
    }
    return "404 Not Found";
}

void routerFree(Router* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->routes[i]);
        free(obj->handlers[i]);
    }
    free(obj->routes);
    free(obj->handlers);
    free(obj);
}