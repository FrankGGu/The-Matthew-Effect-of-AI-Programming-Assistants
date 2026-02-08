var maximumCandies = function(candies, k) {
    let left = 0;
    let right = 0;
    for (let pile of candies) {
        right = Math.max(right, pile);
    }

    let ans = 0;

    while (left <= right) {
        let mid = Math.floor(left + (right - left) / 2);

        let childrenCount = 0;
        if (mid === 0) {
            // If 0 candies per child, we can always allocate to k children.
            // This effectively makes the condition (childrenCount >= k) true,
            // allowing 0 to be considered as a valid answer and then
            // trying for positive values.
            childrenCount = k; 
        } else {
            for (let pile of candies) {
                childrenCount += Math.floor(pile / mid);
            }
        }

        if (childrenCount >= k) {
            // We can allocate 'mid' candies to at least 'k' children.
            // This 'mid' is a possible answer, so store it.
            // Try for more candies per child by moving 'left' up.
            ans = mid;
            left = mid + 1;
        } else {
            // We cannot allocate 'mid' candies to 'k' children.
            // Need to reduce the number of candies per child.
            right = mid - 1;
        }
    }

    return ans;
};