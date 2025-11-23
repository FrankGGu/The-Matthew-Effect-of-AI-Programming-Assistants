#include <vector>
#include <algorithm>

using namespace std;

int matchPlayersAndTrainers(vector<int>& players, vector<int>& trainers) {
    sort(players.begin(), players.end());
    sort(trainers.begin(), trainers.end());

    int playerIndex = 0, trainerIndex = 0;
    int matches = 0;

    while (playerIndex < players.size() && trainerIndex < trainers.size()) {
        if (players[playerIndex] <= trainers[trainerIndex]) {
            matches++;
            playerIndex++;
        }
        trainerIndex++;
    }

    return matches;
}