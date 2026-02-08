#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int closestMeetingNode(int* edges, int edgesSize, int node1, int node2) {
    int dist1[edgesSize];
    int dist2[edgesSize];
    for (int i = 0; i < edgesSize; i++) {
        dist1[i] = INT_MAX;
        dist2[i] = INT_MAX;
    }

    int curr = node1;
    int dist = 0;
    while (curr != -1 && dist1[curr] == INT_MAX) {
        dist1[curr] = dist++;
        curr = edges[curr];
    }

    curr = node2;
    dist = 0;
    while (curr != -1 && dist2[curr] == INT_MAX) {
        dist2[curr] = dist++;
        curr = edges[curr];
    }

    int minDist = INT_MAX;
    int ans = -1;
    for (int i = 0; i < edgesSize; i++) {
        if (dist1[i] != INT_MAX && dist2[i] != INT_MAX) {
            int maxDist = (dist1[i] > dist2[i]) ? dist1[i] : dist2[i];
            if (maxDist < minDist) {
                minDist = maxDist;
                ans = i;
            }
        }
    }

    return ans;
}