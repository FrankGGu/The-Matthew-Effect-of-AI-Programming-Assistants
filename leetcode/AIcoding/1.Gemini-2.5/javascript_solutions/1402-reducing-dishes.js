var maxSatisfaction = function(satisfaction) {
    satisfaction.sort((a, b) => a - b);

    let maxLTC = 0;
    let currentSumOfSatisfactions = 0;
    let currentLTC = 0;

    for (let i = satisfaction.length - 1; i >= 0; i--) {
        currentSumOfSatisfactions += satisfaction[i];
        if (currentSumOfSatisfactions > 0) {
            currentLTC += currentSumOfSatisfactions;
            maxLTC = Math.max(maxLTC, currentLTC);
        } else {
            // If the sum of satisfactions of the current set of dishes
            // (from satisfaction[i] to satisfaction[n-1]) is not positive,
            // then adding any more dishes (which are smaller or more negative)
            // will only decrease the total sum of satisfactions, and thus
            // decrease the like-time coefficient. So, we can stop.
            break;
        }
    }

    return maxLTC;
};