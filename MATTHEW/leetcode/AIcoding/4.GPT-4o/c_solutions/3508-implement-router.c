typedef struct {
    struct RouterNode *children[256];
    bool isEnd;
} RouterNode;

typedef struct {
    RouterNode *root;
} Router;

Router* routerCreate() {
    Router *router = (Router *)malloc(sizeof(Router));
    router->root = (RouterNode *)malloc(sizeof(RouterNode));
    memset(router->root->children, 0, sizeof(router->root->children));
    router->root->isEnd = false;
    return router;
}

void routerAddRoute(Router* router, char* route) {
    RouterNode *node = router->root;
    while (*route) {
        if (!node->children[(unsigned char)*route]) {
            node->children[(unsigned char)*route] = (RouterNode *)malloc(sizeof(RouterNode));
            memset(node->children[(unsigned char)*route]->children, 0, sizeof(node->children[(unsigned char)*route]->children));
            node->children[(unsigned char)*route]->isEnd = false;
        }
        node = node->children[(unsigned char)*route];
        route++;
    }
    node->isEnd = true;
}

bool routerLookup(Router* router, char* route) {
    RouterNode *node = router->root;
    while (*route) {
        if (!node->children[(unsigned char)*route]) {
            return false;
        }
        node = node->children[(unsigned char)*route];
        route++;
    }
    return node->isEnd;
}

void routerFree(Router* router) {
    void freeNode(RouterNode* node) {
        if (!node) return;
        for (int i = 0; i < 256; i++) {
            freeNode(node->children[i]);
        }
        free(node);
    }
    freeNode(router->root);
    free(router);
}