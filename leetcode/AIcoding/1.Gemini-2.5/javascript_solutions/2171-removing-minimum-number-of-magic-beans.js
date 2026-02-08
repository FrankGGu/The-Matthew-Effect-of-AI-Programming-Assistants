var removeBeans = function(beans) {
    beans.sort((a, b) => a - b);

    let totalSum = 0;
    for (let i = 0; i < beans.length; i++) {
        totalSum += beans[i];
    }

    let maxRemainingBeans = 0;
    let n = beans.length;

    for (let i = 0; i < n; i++) {
        // If beans[i] is chosen as the target number of beans for all remaining bags,
        // then all bags from index i to n-1 will be reduced to beans[i] beans.
        // The number of such bags is (n - i).
        // The total beans remaining in this scenario would be (n - i) * beans[i].
        let currentRemainingBeans = (n - i) * beans[i];
        if (currentRemainingBeans > maxRemainingBeans) {
            maxRemainingBeans = currentRemainingBeans;
        }
    }

    // The minimum number of beans to remove is the total sum minus the maximum beans we can keep.
    return totalSum - maxRemainingBeans;
};