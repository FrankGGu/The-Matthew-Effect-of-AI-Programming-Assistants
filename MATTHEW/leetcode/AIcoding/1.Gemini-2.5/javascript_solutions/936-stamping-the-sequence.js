var movesToStamp = function(stamp, target) {
    const m = stamp.length;
    const n = target.length;

    const ans = []; // Stores the indices where stamps were placed (in reverse order of processing)
    const q = [];   // Queue for indices of windows that are ready to be "unstamped"

    // is_stamped[k] is true if target[k] has been conceptually replaced by '?'
    const is_stamped = new Array(n).fill(false);
    let stamped_count = 0; // Number of '?' characters in the target (conceptually)

    // windows[i] stores information about the substring target[i...i+m-1]
    // Each element is an object with:
    //   - made: Set of indices (relative to target) that match stamp[k] AND are not '?'
    //   - todo: Set of indices (relative to target) that do NOT match stamp[k] AND are not '?'
    const windows = new Array(n - m + 1);

    // Initialize windows and populate the queue with initially ready windows
    for (let i = 0; i <= n - m; i++) {
        const curMade = new Set();
        const curTodo = new Set();

        for (let k = 0; k < m; k++) {
            const char_idx = i + k;
            // target string initially consists only of lowercase letters, so no '?'
            if (target[char_idx] === stamp[k]) {
                curMade.add(char_idx);
            } else { // target[char_idx] !== stamp[k]
                curTodo.add(char_idx);
            }
        }

        windows[i] = { made: curMade, todo: curTodo };

        // A window is ready to be "unstamped" if:
        // 1. There are no mismatches (all characters either match stamp or are already '?').
        //    This is represented by `curTodo.size === 0`.
        // 2. It must contain at least one original character that matches the stamp.
        //    This is represented by `curMade.size > 0`. This ensures we only unstamp
        //    windows that actually contribute to changing non-'?' characters to '?'.
        if (curTodo.size === 0 && curMade.size > 0) {
            q.push(i);
        }
    }

    // Process the queue
    while (q.length > 0) {
        const idx = q.shift();
        ans.push(idx);

        // Mark characters in the window [idx, idx+m-1] as stamped ('?')
        for (let k = 0; k < m; k++) {
            const char_idx = idx + k;
            if (!is_stamped[char_idx]) {
                is_stamped[char_idx] = true;
                stamped_count++;

                // Now that target[char_idx] is '?', it might affect other overlapping windows.
                // Iterate through all windows 'j' that overlap with 'char_idx'.
                // A window 'j' overlaps if j <= char_idx < j + m.
                // This means j is in the range [max(0, char_idx - m + 1), min(n - m, char_idx)].
                for (let j = Math.max(0, char_idx - m + 1); j <= Math.min(n - m, char_idx); j++) {
                    // If 'char_idx' was a mismatch for window 'j', it's no longer a mismatch.
                    if (windows[j].todo.has(char_idx)) {
                        windows[j].todo.delete(char_idx);
                        // If window 'j' now has no mismatches, it's a candidate for unstamping.
                        if (windows[j].todo.size === 0) {
                            // And it must still contain original characters that match the stamp.
                            if (windows[j].made.size > 0) {
                                q.push(j);
                            }
                        }
                    }
                    // If 'char_idx' was a match for window 'j', it's no longer a match.
                    if (windows[j].made.has(char_idx)) {
                        windows[j].made.delete(char_idx);
                        // If windows[j].made.size becomes 0, it means this window is now all '?'s (or contains no original matching characters).
                        // If it was already in the queue, it's fine. If it wasn't, it won't be pushed
                        // because the `made.size > 0` condition prevents pushing all-'?' windows.
                    }
                }
            }
        }
    }

    // If not all characters in target were stamped, it's impossible.
    if (stamped_count !== n) {
        return [];
    } else {
        // Reverse the answer because we worked backward from target to all '?'s.
        // The problem asks for the sequence to transform all '?'s to target.
        return ans.reverse();
    }
};