#include <string>
#include <vector>
#include <algorithm>
#include <map>
#include <climits> // For INT_MAX

using namespace std;

map<pair<string, string>, int> memo;

string clean(string s) {
    bool changed = true;
    while (changed) {
        changed = false;
        string temp = "";
        int i = 0;
        while (i < s.length()) {
            int j = i;
            while (j < s.length() && s[j] == s[i]) {
                j++;
            }
            // If a sequence of 3 or more identical balls is found, remove it
            if (j - i >= 3) {
                changed = true; // Board was changed, need another pass
            } else {
                // Otherwise, keep the balls
                temp += s.substr(i, j - i);
            }
            i = j;
        }
        s = temp; // Update the board for the next iteration
    }
    return s;
}

int dfs(string board, string hand) {
    // Clean the board first to simplify the state
    board = clean(board);

    // Base case 1: If the board is empty, we successfully cleared it
    if (board.empty()) {
        return 0;
    }

    // Base case 2: If no balls are left in hand but the board is not empty,
    // we cannot clear the board. Use a large value to represent infinity.
    if (hand.empty()) {
        return INT_MAX / 2; 
    }

    // Sort the hand string to create a canonical key for memoization
    // This ensures that different permutations of the same hand are treated as the same state
    string sorted_hand = hand;
    sort(sorted_hand.begin(), sorted_hand.end());

    // Check if this state has been computed before
    if (memo.count({board, sorted_hand})) {
        return memo[{board, sorted_hand}];
    }

    int min_balls = INT_MAX / 2; // Initialize with infinity

    // Iterate through all possible insertion positions in the board
    // 'i' can range from 0 (before the first ball) to board.length() (after the last ball)
    for (int i = 0; i <= board.length(); ++i) {
        // Iterate through all available balls in hand
        for (int j = 0; j < hand.length(); ++j) {
            // Optimization: Skip duplicate balls in hand if they are adjacent.
            // Inserting 'R' from hand[0] or hand[1] (if hand="RR") at the same
            // board position yields the same result, so we only need to try it once.
            if (j > 0 && hand[j] == hand[j-1]) {
                continue;
            }

            char ball_to_insert = hand[j];

            // Create a new hand string by removing the ball that was just used
            string new_hand = hand.substr(0, j) + hand.substr(j + 1);

            // Create a new board string by inserting the ball at position 'i'
            string new_board = board.substr(0, i) + ball_to_insert + board.substr(i);

            // Recursively call dfs with the new board and hand
            int res = dfs(new_board, new_hand);

            // If a valid path was found (res is not infinity), update min_balls
            if (res != INT_MAX / 2) {
                min_balls = min(min_balls, res + 1); // +1 for the current ball inserted
            }
        }
    }

    // Store the computed minimum balls for this state in the memoization table
    // and return the result
    return memo[{board, sorted_hand}] = min_balls;
}

class Solution {
public:
    int findMinStep(string board, string hand) {
        // Clear the memoization table for each new test case
        memo.clear();

        // Start the DFS from the initial board and hand
        int result = dfs(board, hand);

        // If the result is still INT_MAX / 2, it means no solution was found
        return (result == INT_MAX / 2) ? -1 : result;
    }
};