#include <vector>
#include <algorithm>

class Solution {
public:
    int videoStitching(std::vector<std::vector<int>>& clips, int T) {
        if (T == 0) {
            return 0;
        }

        // Sort clips by their start times. If start times are equal, sort by end times (optional but good practice).
        std::sort(clips.begin(), clips.end());

        int num_clips = 0;
        int current_reach = 0; // The maximum time covered by `num_clips` clips
        int max_reach_possible_in_this_step = 0; // The maximum time we can reach by adding one more clip from the current segment
        int clip_idx = 0; // Pointer to iterate through sorted clips

        while (current_reach < T) {
            num_clips++;
            int prev_current_reach = current_reach; // Store current_reach before trying to extend it

            // Find all clips that start at or before `prev_current_reach`
            // and determine the maximum end time among them.
            while (clip_idx < clips.size() && clips[clip_idx][0] <= prev_current_reach) {
                max_reach_possible_in_this_step = std::max(max_reach_possible_in_this_step, clips[clip_idx][1]);
                clip_idx++;
            }

            // If no clip could extend `prev_current_reach`, or the best clip didn't extend it,
            // it means there's a gap or we are stuck.
            if (max_reach_possible_in_this_step <= prev_current_reach) {
                return -1;
            }

            // Make the jump: update `current_reach` to the furthest point found.
            current_reach = max_reach_possible_in_this_step;

            // If we have reached or surpassed T, we are done.
            if (current_reach >= T) {
                return num_clips;
            }
        }

        // This part should ideally not be reached if `current_reach >= T` is handled inside the loop.
        // It's a fallback for cases where the loop condition might be tricky with `T`.
        return -1;
    }
};