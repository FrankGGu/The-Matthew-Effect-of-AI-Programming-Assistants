#include <string>
#include <vector>
#include <unordered_map>

class Solution {
public:
    // memo: Stores results for previously computed 'bottom' strings.
    // 0 = unvisited, 1 = true (can form pyramid), -1 = false (cannot form pyramid)
    std::unordered_map<std::string, int> memo;

    // transitions: Stores allowed transitions. Key is a 2-char string (e.g., "AB"),
    // value is a vector of characters that can be placed above it (e.g., ['D', 'E']).
    std::unordered_map<std::string, std::vector<char>> transitions;

    bool pyramidTransition(std::string bottom, std::vector<std::string>& allowed) {
        // Populate the transitions map from the 'allowed' rules.
        for (const std::string& s : allowed) {
            transitions[s.substr(0, 2)].push_back(s[2]);
        }

        // Start the recursive process from the initial 'bottom' string.
        return canFormPyramid(bottom);
    }

    // Main recursive function to determine if a given 'currentBottom' string
    // can form the base of a valid pyramid.
    bool canFormPyramid(std::string currentBottom) {
        // Memoization check: if we've already computed this 'currentBottom', return the stored result.
        if (memo.count(currentBottom)) {
            return memo[currentBottom] == 1;
        }

        // Base case: If the current bottom layer has only one character, it's a valid pyramid.
        if (currentBottom.length() == 1) {
            memo[currentBottom] = 1; // Store result as true
            return true;
        }

        // Use a string builder to efficiently construct the next layer.
        std::string nextLayerBuilder = "";

        // Try to build the next layer character by character using backtracking,
        // and recursively check if that next layer can form a pyramid.
        bool possible = buildNextLayerAndCheck(currentBottom, 0, nextLayerBuilder);

        // Store the computed result for 'currentBottom' before returning.
        memo[currentBottom] = possible ? 1 : -1;
        return possible;
    }

    // Helper function to build the next layer character by character using backtracking.
    // prevLayer: The layer below the one we are currently building.
    // prevIdx: The current index in 'prevLayer' to form a 2-character pair
    //          (prevLayer[prevIdx], prevLayer[prevIdx+1]).
    // currentNextLayer: The string representing the layer being built (passed by reference for efficiency).
    bool buildNextLayerAndCheck(const std::string& prevLayer, int prevIdx, std::string& currentNextLayer) {
        // Base case for building the next layer:
        // If 'prevIdx' has reached the second-to-last character of 'prevLayer',
        // it means we have processed all pairs needed to form 'currentNextLayer'.
        // 'currentNextLayer' is now fully formed.
        if (prevIdx == prevLayer.length() - 1) {
            // Check if this newly formed 'currentNextLayer' can form a pyramid.
            return canFormPyramid(currentNextLayer);
        }

        // Form the 2-character pair from the previous layer.
        std::string pair = prevLayer.substr(prevIdx, 2);

        // Check if this pair has any allowed transitions.
        if (!transitions.count(pair)) {
            return false; // No character can be placed above this pair, so this path is invalid.
        }

        // Iterate through all possible characters that can be placed above the 'pair'.
        for (char nextChar : transitions[pair]) {
            currentNextLayer.push_back(nextChar); // Add the character to the current next layer.

            // Recursively try to build the rest of 'currentNextLayer' by moving to the next pair in 'prevLayer'.
            if (buildNextLayerAndCheck(prevLayer, prevIdx + 1, currentNextLayer)) {
                return true; // If a valid path is found, propagate true upwards.
            }

            currentNextLayer.pop_back(); // Backtrack: remove the character to try the next alternative.
        }

        // If no character for the current position leads to a valid pyramid, return false.
        return false;
    }
};