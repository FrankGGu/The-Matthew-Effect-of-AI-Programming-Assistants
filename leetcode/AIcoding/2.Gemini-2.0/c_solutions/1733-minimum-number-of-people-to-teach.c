#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTeachings(int n, int** languages, int languagesSize, int* languagesColSize, int** friendships, int friendshipsSize, int* friendshipsColSize) {
    bool canCommunicate[friendshipsSize];
    for (int i = 0; i < friendshipsSize; i++) {
        canCommunicate[i] = false;
    }

    for (int i = 0; i < friendshipsSize; i++) {
        int u = friendships[i][0];
        int v = friendships[i][1];

        for (int j = 0; j < languagesColSize[u - 1]; j++) {
            int langU = languages[u - 1][j];
            for (int k = 0; k < languagesColSize[v - 1]; k++) {
                int langV = languages[v - 1][k];
                if (langU == langV) {
                    canCommunicate[i] = true;
                    break;
                }
            }
            if (canCommunicate[i]) break;
        }
    }

    int minTeachings = friendshipsSize;
    for (int lang = 1; lang <= n; lang++) {
        int teachings = 0;
        bool teachU[languagesSize];
        bool teachV[languagesSize];
        for (int i = 0; i < languagesSize; i++) {
            teachU[i] = false;
            teachV[i] = false;
        }

        for (int i = 0; i < friendshipsSize; i++) {
            if (!canCommunicate[i]) {
                int u = friendships[i][0];
                int v = friendships[i][1];

                bool uKnowsLang = false;
                for (int j = 0; j < languagesColSize[u - 1]; j++) {
                    if (languages[u - 1][j] == lang) {
                        uKnowsLang = true;
                        break;
                    }
                }

                bool vKnowsLang = false;
                for (int j = 0; j < languagesColSize[v - 1]; j++) {
                    if (languages[v - 1][j] == lang) {
                        vKnowsLang = true;
                        break;
                    }
                }

                if (!uKnowsLang) {
                    if (!teachU[u - 1]) {
                        teachings++;
                        teachU[u - 1] = true;
                    }
                }

                if (!vKnowsLang) {
                    if (!teachV[v - 1]) {
                        teachings++;
                        teachV[v - 1] = true;
                    }
                }
            }
        }

        int distinctTeachings = 0;
        bool taught[languagesSize];
        for (int i = 0; i < languagesSize; i++) {
            taught[i] = false;
        }

        for (int i = 0; i < friendshipsSize; i++) {
             if (!canCommunicate[i]) {
                int u = friendships[i][0];
                int v = friendships[i][1];

                bool uKnowsLang = false;
                for (int j = 0; j < languagesColSize[u - 1]; j++) {
                    if (languages[u - 1][j] == lang) {
                        uKnowsLang = true;
                        break;
                    }
                }

                bool vKnowsLang = false;
                for (int j = 0; j < languagesColSize[v - 1]; j++) {
                    if (languages[v - 1][j] == lang) {
                        vKnowsLang = true;
                        break;
                    }
                }

                if (!uKnowsLang && !taught[u-1]) {
                    taught[u-1] = true;
                }

                if (!vKnowsLang && !taught[v-1]) {
                    taught[v-1] = true;
                }
             }
        }

        distinctTeachings = 0;
        for (int i = 0; i < languagesSize; i++) {
            if (taught[i]) {
                distinctTeachings++;
            }
        }

        if (distinctTeachings < minTeachings) {
            minTeachings = distinctTeachings;
        }
    }

    return minTeachings;
}