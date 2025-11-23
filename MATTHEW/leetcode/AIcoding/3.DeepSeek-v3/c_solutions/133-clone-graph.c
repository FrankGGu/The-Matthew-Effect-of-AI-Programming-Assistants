/**
 * Definition for a Node.
 * struct Node {
 *     int val;
 *     int numNeighbors;
 *     struct Node** neighbors;
 * };
 */

struct Node* dfs(struct Node* s, struct Node** visited) {
    if (s == NULL) return NULL;
    if (visited[s->val] != NULL) return visited[s->val];

    struct Node* clone = (struct Node*)malloc(sizeof(struct Node));
    clone->val = s->val;
    clone->numNeighbors = s->numNeighbors;
    visited[clone->val] = clone;

    if (s->numNeighbors > 0) {
        clone->neighbors = (struct Node**)malloc(sizeof(struct Node*) * s->numNeighbors);
        for (int i = 0; i < s->numNeighbors; i++) {
            clone->neighbors[i] = dfs(s->neighbors[i], visited);
        }
    } else {
        clone->neighbors = NULL;
    }

    return clone;
}

struct Node *cloneGraph(struct Node *s) {
    struct Node* visited[101] = {NULL};
    return dfs(s, visited);
}