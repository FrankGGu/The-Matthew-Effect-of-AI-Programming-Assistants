#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        int min_round = n, max_round = 1;

        function<void(int, int, int)> solve = [&](int current_round, int players_left, int current_first, int current_second) {
            if (current_first > current_second) swap(current_first, current_second);

            if (current_first == (current_second + 1) / 2) {
                min_round = min(min_round, current_round);
                max_round = max(max_round, current_round);
                return;
            }

            if (players_left == 1) {
                min_round = min(min_round, current_round);
                max_round = max(max_round, current_round);
                return;
            }

            for (int i = 0; i < (1 << (players_left - 1)); ++i) {
                int next_first = -1, next_second = -1;
                int next_players = 0;
                vector<bool> advanced(players_left + 1, false);

                for (int j = 1; j <= players_left; j += 2) {
                    if ((i >> ((j - 1) / 2)) & 1) {
                        if (j == current_first) next_first = ++next_players;
                        else if (j == current_second) next_second = ++next_players;
                        else ++next_players;
                        advanced[j] = true;
                    } else {
                        if (j + 1 == current_first) next_first = ++next_players;
                        else if (j + 1 == current_second) next_second = ++next_players;
                        else ++next_players;
                        advanced[j + 1] = true;
                    }
                }
                if (next_first == -1 && advanced[current_first]) next_first = ++next_players;
                if (next_second == -1 && advanced[current_second]) next_second = ++next_players;

                if (next_first == -1) {
                    for(int j = 1; j <= players_left; ++j){
                        if(!advanced[j]){
                            next_first = ++next_players;
                            break;
                        }
                    }
                }
                if (next_second == -1) {
                    for(int j = 1; j <= players_left; ++j){
                        if(!advanced[j] && next_first != ++next_players){
                            next_second = next_players;
                            break;
                        }
                        --next_players;
                    }
                }

                solve(current_round + 1, (players_left + 1) / 2, next_first, next_second);
            }
        };

        int players_left = n;
        solve(1, players_left, firstPlayer, secondPlayer);

        return {min_round, max_round};
    }
};