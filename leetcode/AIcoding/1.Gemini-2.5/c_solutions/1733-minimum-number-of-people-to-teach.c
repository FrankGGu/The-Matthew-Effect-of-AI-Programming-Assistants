#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memset
#include <limits.h> // For INT_MAX

int minimumTeachings(int n, int** languages, int languagesSize, int* languagesColSize, int** friendships, int friendshipsSize, int* friendshipsColSize) {
    int max_lang_id = 0;
    for (int i = 0; i < languagesSize; i++) {
        for (int j = 0; j < languagesColSize[i]; j++) {
            if (languages[i][j] > max_lang_id) {
                max_lang_id = languages[i][j];
            }
        }
    }

    bool speaks[n + 1][max_lang_id + 1];
    memset(speaks, 0, sizeof(speaks));

    for (int i = 0; i < languagesSize; i++) {
        int person_id = i + 1;
        for (int j = 0; j < languagesColSize[i]; j++) {
            speaks[person_id][languages[i][j]] = true;
        }
    }

    bool is_involved_in_unhappy[n + 1];
    memset(is_involved_in_unhappy, 0, sizeof(is_involved_in_unhappy));

    int unhappy_friendships_count = 0;

    for (int i = 0; i < friendshipsSize; i++) {
        int u = friendships[i][0];
        int v = friendships[i][1];

        bool share_common_language = false;
        for (int j = 0; j < languagesColSize[u-1]; j++) {
            int lang_id = languages[u-1][j];
            if (speaks[v][lang_id]) {
                share_common_language = true;
                break;
            }
        }

        if (!share_common_language) {
            unhappy_friendships_count++;
            is_involved_in_unhappy[u] = true;
            is_involved_in_unhappy[v] = true;
        }
    }

    if (unhappy_friendships_count == 0) {
        return 0;
    }

    int min_people_to_teach = INT_MAX;

    for (int L = 1; L <= max_lang_id; L++) {
        int current_people_to_teach_for_L = 0;
        for (int person_id = 1; person_id <= n; person_id++) {
            if (is_involved_in_unhappy[person_id] && !speaks[person_id][L]) {
                current_people_to_teach_for_L++;
            }
        }
        if (current_people_to_teach_for_L < min_people_to_teach) {
            min_people_to_teach = current_people_to_teach_for_L;
        }
    }

    return min_people_to_teach;
}