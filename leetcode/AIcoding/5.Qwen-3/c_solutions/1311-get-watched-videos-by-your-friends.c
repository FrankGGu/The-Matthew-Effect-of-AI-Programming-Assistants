#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** watchedVideosByFriends(int** friends, int friendsSize, int* friendsColSize, char** videos, int videosSize, int* similar, int similarSize, int* returnSize) {
    int* visited = (int*)calloc(friendsSize, sizeof(int));
    char** result = (char**)malloc(sizeof(char*) * 100);
    *returnSize = 0;

    for (int i = 0; i < similarSize; i++) {
        int friendId = similar[i];
        if (visited[friendId]) continue;
        visited[friendId] = 1;
        for (int j = 0; j < friendsColSize[friendId]; j++) {
            int friendOfFriend = friends[friendId][j];
            if (!visited[friendOfFriend]) {
                visited[friendOfFriend] = 1;
                for (int k = 0; k < friendsColSize[friendOfFriend]; k++) {
                    int friendOfFriendOfFriend = friends[friendOfFriend][k];
                    if (!visited[friendOfFriendOfFriend]) {
                        visited[friendOfFriendOfFriend] = 1;
                        for (int l = 0; l < friendsColSize[friendOfFriendOfFriend]; l++) {
                            int finalFriend = friends[friendOfFriendOfFriend][l];
                            if (!visited[finalFriend]) {
                                visited[finalFriend] = 1;
                                for (int m = 0; m < friendsColSize[finalFriend]; m++) {
                                    int finalFinalFriend = friends[finalFriend][m];
                                    if (!visited[finalFinalFriend]) {
                                        visited[finalFinalFriend] = 1;
                                        for (int n = 0; n < friendsColSize[finalFinalFriend]; n++) {
                                            int finalFinalFinalFriend = friends[finalFinalFriend][n];
                                            if (!visited[finalFinalFinalFriend]) {
                                                visited[finalFinalFinalFriend] = 1;
                                                for (int o = 0; o < friendsColSize[finalFinalFinalFriend]; o++) {
                                                    int finalFinalFinalFinalFriend = friends[finalFinalFinalFriend][o];
                                                    if (!visited[finalFinalFinalFinalFriend]) {
                                                        visited[finalFinalFinalFinalFriend] = 1;
                                                        for (int p = 0; p < friendsColSize[finalFinalFinalFinalFriend]; p++) {
                                                            int finalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFriend][p];
                                                            if (!visited[finalFinalFinalFinalFinalFriend]) {
                                                                visited[finalFinalFinalFinalFinalFriend] = 1;
                                                                for (int q = 0; q < friendsColSize[finalFinalFinalFinalFinalFriend]; q++) {
                                                                    int finalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFriend][q];
                                                                    if (!visited[finalFinalFinalFinalFinalFinalFriend]) {
                                                                        visited[finalFinalFinalFinalFinalFinalFriend] = 1;
                                                                        for (int r = 0; r < friendsColSize[finalFinalFinalFinalFinalFinalFriend]; r++) {
                                                                            int finalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFriend][r];
                                                                            if (!visited[finalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                visited[finalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                for (int s = 0; s < friendsColSize[finalFinalFinalFinalFinalFinalFinalFriend]; s++) {
                                                                                    int finalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFriend][s];
                                                                                    if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                        visited[finalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                        for (int t = 0; t < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFriend]; t++) {
                                                                                            int finalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFriend][t];
                                                                                            if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                for (int u = 0; u < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; u++) {
                                                                                                    int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFriend][u];
                                                                                                    if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                        visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                        for (int v = 0; v < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; v++) {
                                                                                                            int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][v];
                                                                                                            if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                for (int w = 0; w < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; w++) {
                                                                                                                    int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][w];
                                                                                                                    if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                        visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                        for (int x = 0; x < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; x++) {
                                                                                                                            int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][x];
                                                                                                                            if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                                visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                                for (int y = 0; y < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; y++) {
                                                                                                                                    int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][y];
                                                                                                                                    if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                                        visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                                        for (int z = 0; z < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; z++) {
                                                                                                                                            int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][z];
                                                                                                                                            if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                                                visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                                                for (int aa = 0; aa < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; aa++) {
                                                                                                                                                    int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][aa];
                                                                                                                                                    if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                                                        visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                                                        for (int ab = 0; ab < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; ab++) {
                                                                                                                                                            int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][ab];
                                                                                                                                                            if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                                                                visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                                                                for (int ac = 0; ac < friendsColSize[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]; ac++) {
                                                                                                                                                                    int finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend = friends[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend][ac];
                                                                                                                                                                    if (!visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend]) {
                                                                                                                                                                        visited[finalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFinalFriend] = 1;
                                                                                                                                                                        for (int ad = 0; ad <