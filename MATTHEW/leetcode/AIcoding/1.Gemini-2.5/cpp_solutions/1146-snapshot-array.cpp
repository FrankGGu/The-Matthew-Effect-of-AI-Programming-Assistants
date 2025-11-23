#include <vector>
#include <algorithm> // For std::upper_bound
#include <utility>   // For std::pair, std::make_pair

class SnapshotArray {
private:
    // For each index, store a list of (snap_id, value) pairs.
    // Each list `history[index]` is sorted by `snap_id`.
    // This structure allows efficient lookup of values at specific snap_ids using binary search.
    std::vector<std::vector<std::pair<int, int>>> history;
    // Tracks the current snapshot ID. Incremented with each `snap()` call.
    int current_snap_id;

public:
    SnapshotArray(int length) {
        // Initialize the history for `length` indices.
        // Each index starts with an empty history.
        history.resize(length);
        // The first snapshot ID is 0.
        current_snap_id = 0;
    }

    void set(int index, int val) {
        // If the history for `index` is empty, or the last recorded change
        // for `index` was from a previous `snap_id`, then this `set` operation
        // represents a new state for the current `current_snap_id`.
        if (history[index].empty() || history[index].back().first < current_snap_id) {
            history[index].push_back({current_snap_id, val});
        } else {
            // If the last recorded change for `index` was for the `current_snap_id`,
            // it means multiple `set` operations occurred on `index` before a `snap()` call.
            // Only the most recent `set` operation for this `current_snap_id` matters,
            // so we update the value of the last entry.
            history[index].back().second = val;
        }
    }

    int snap() {
        // Return the current `snap_id` and then increment it for the next snapshot.
        return current_snap_id++;
    }

    int get(int index, int snap_id) {
        // We need to find the value of `index` at the given `snap_id`.
        // This means finding the latest change (largest `s_id`) in `history[index]`
        // such that `s_id <= snap_id`.
        //
        // `std::upper_bound` finds the first element that is *greater than* the target.
        // We use `std::make_pair(snap_id, 2000000000)` as the target. The large
        // second value ensures that the comparison primarily relies on the `snap_id`
        // (due to `std::pair`'s lexicographical comparison), effectively finding
        // the first entry whose `snap_id` is strictly greater than `snap_id`.
        // Any value greater than the maximum possible `val` (10^9) would work.
        auto it = std::upper_bound(history[index].begin(), history[index].end(), 
                                   std::make_pair(snap_id, 2000000000));

        // If `it` is `history[index].begin()`, it means all entries in `history[index]`
        // have a `snap_id` greater than the requested `snap_id`.
        // In this scenario, the element was never set at or before `snap_id`,
        // so its value is the initial default of 0.
        if (it == history[index].begin()) {
            return 0;
        } else {
            // Otherwise, `it` points to the first element with `snap_id > snap_id`.
            // The element immediately before `it` (`--it`) is the one with the
            // largest `snap_id` that is less than or equal to the requested `snap_id`.
            return (--it)->second;
        }
    }
};