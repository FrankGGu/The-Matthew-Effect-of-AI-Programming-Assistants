var minimumGroups = function(counts) {
    let maxCount = 0;
    for (const count of counts) {
        maxCount = Math.max(maxCount, count);
    }

    // Function to check if a given 'm_val' (which represents the smallest group size 'm' from the problem description)
    // is feasible for all item counts, and if so, returns the total minimum number of groups.
    // Returns Infinity if 'm_val' is not feasible.
    const check = (m_val) => {
        // min_s is the minimum allowed size for any group, derived from m_val.
        // max_s is the maximum allowed size for any group, which is m_val itself.
        // A group must have at least 1 item, so min_s must be at least 1.
        const min_s = Math.max(1, Math.floor(m_val / 2));
        const max_s = m_val;

        let totalGroups = 0;
        for (const c of counts) {
            // To minimize the number of groups for a specific item count 'c',
            // we should try to make each group as large as possible, up to max_s.
            // So, the minimum number of groups required for 'c' is ceil(c / max_s).
            const k_min_candidate = Math.ceil(c / max_s);

            // Now, we must verify if it's actually possible to form 'c' items into k_min_candidate groups,
            // where each group has a size between min_s and max_s.
            // If we have k_min_candidate groups, and each must contain at least min_s items,
            // then the total number of items must be at least k_min_candidate * min_s.
            // If c is less than k_min_candidate * min_s, it's impossible to form k_min_candidate groups
            // because there aren't enough items to meet the minimum size requirement for each group.
            if (k_min_candidate * min_s > c) {
                return Infinity; // This m_val is not feasible for this count 'c'.
            }
            totalGroups += k_min_candidate;
        }
        return totalGroups;
    };

    let low = 1;
    // The maximum possible value for 'm_val' (the smallest group size) can be `maxCount`.
    // If m_val = maxCount, then min_s = floor(maxCount/2) and max_s = maxCount.
    // This range covers all possible valid 'm_val' values.
    let high = maxCount; 
    let minTotalGroups = Infinity;

    // Binary search to find the 'm_val' that results in the minimum total number of groups.
    // The function `check(m_val)` returns a total number of groups that is generally non-increasing
    // as `m_val` increases, until it becomes `Infinity` (not feasible).
    // We are looking for the minimum value returned by `check(m_val)`.
    while (low <= high) {
        const mid = low + Math.floor((high - low) / 2);
        const currentGroups = check(mid);

        if (currentGroups !== Infinity) {
            // If 'mid' is a feasible smallest group size, we record the total groups.
            minTotalGroups = Math.min(minTotalGroups, currentGroups);
            // Since increasing 'm_val' tends to decrease or keep the total groups the same,
            // we try a larger 'm_val' to see if we can find an even smaller total number of groups.
            low = mid + 1;
        } else {
            // If 'mid' is not feasible, it means 'mid' is too large (or too restrictive for min_s).
            // We need to try a smaller 'm_val'.
            high = mid - 1;
        }
    }

    return minTotalGroups;
};