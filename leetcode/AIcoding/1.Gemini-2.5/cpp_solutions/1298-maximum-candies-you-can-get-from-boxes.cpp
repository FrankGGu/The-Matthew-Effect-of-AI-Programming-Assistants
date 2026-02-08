#include <vector>
#include <queue>
#include <set>
#include <numeric> // For std::iota if needed, but not here

class Solution {
public:
    long long maxCandies(std::vector<int>& status, std::vector<int>& candies, std::vector<std::vector<int>>& keys, std::vector<std::vector<int>>& containedBoxes, std::vector<int>& initialBoxes) {
        int n = status.size();

        long long total_candies = 0;

        // has_key[i] is true if we possess a key for box i
        std::vector<bool> has_key(n, false);
        // has_box[i] is true if we have encountered box i (either initial or contained)
        std::vector<bool> has_box(n, false);
        // opened[i] is true if box i has been opened and its contents processed
        std::vector<bool> opened(n, false);

        // Queue for boxes that are currently openable and not yet processed in this iteration
        std::queue<int> q;
        // Set for boxes that we know about (has_box[i] == true) but are currently locked
        // (status[i] == 0 AND has_key[i] == false)
        std::set<int> waiting_to_open; 

        // Initialize with initialBoxes
        for (int box_idx : initialBoxes) {
            has_box[box_idx] = true; // We have possession of this box
            if (status[box_idx] == 1) { // If initially open, add to queue
                q.push(box_idx);
            } else { // If initially closed, add to waiting list
                waiting_to_open.insert(box_idx);
            }
        }

        // This loop continues as long as we can open new boxes.
        // It's a "fixed point" iteration: we keep processing until no more progress can be made.
        // Progress is defined by opening a new box.
        bool new_box_opened_in_iteration = true; 
        while (new_box_opened_in_iteration) {
            new_box_opened_in_iteration = false; // Reset for current iteration

            // Process all boxes currently in the queue
            int q_size = q.size(); 
            for (int i = 0; i < q_size; ++i) {
                int curr_box = q.front();
                q.pop();

                if (opened[curr_box]) {
                    continue; // Already processed this box
                }

                // Mark as opened and collect candies
                opened[curr_box] = true;
                total_candies += candies[curr_box];
                new_box_opened_in_iteration = true; // We successfully opened a new box

                // Process keys found in this box
                for (int key_for_box : keys[curr_box]) {
                    if (!has_key[key_for_box]) { // If this is a newly acquired key
                        has_key[key_for_box] = true;
                        // If this key unlocks a box that was waiting
                        if (waiting_to_open.count(key_for_box)) {
                            waiting_to_open.erase(key_for_box); // No longer waiting
                            q.push(key_for_box); // Add to queue for processing
                            // This also counts as progress, as a previously locked box is now openable.
                            // new_box_opened_in_iteration will already be true if curr_box had candies.
                            // If curr_box had 0 candies, this would still make new_box_opened_in_iteration true.
                        }
                    }
                }

                // Process contained boxes
                for (int contained_box : containedBoxes[curr_box]) {
                    if (!has_box[contained_box]) { // If this is a newly discovered box
                        has_box[contained_box] = true; // Mark as known
                        // If the contained box is initially open OR we have a key for it
                        if (status[contained_box] == 1 || has_key[contained_box]) {
                            if (!opened[contained_box]) { // If not already opened, add to queue
                                q.push(contained_box);
                            }
                        } else { // It's locked and we don't have a key yet
                            waiting_to_open.insert(contained_box); // Add to waiting list
                        }
                    }
                }
            } // End of processing current 'q_size' boxes
        }

        return total_candies;
    }
};