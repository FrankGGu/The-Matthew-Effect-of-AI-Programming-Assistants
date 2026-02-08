var canEat = function(candiesCount, queries) {
    const n = candiesCount.length;
    const prefixSum = new Array(n + 1).fill(0n); // Use BigInt for prefix sums to handle large numbers

    // Calculate prefix sums of candiesCount
    // prefixSum[i] stores the total number of candies of types 0 to i-1
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + BigInt(candiesCount[i]);
    }

    const results = [];

    for (const query of queries) {
        const candyType = query[0];
        const day = BigInt(query[1]);
        const dailyCap = BigInt(query[2]);

        // Interval 1: [first_candy_index_of_type, last_candy_index_of_type]
        // This represents the range of 0-indexed positions for candies of `candyType`.
        // The first candy of `candyType` is at the position `prefixSum[candyType]`.
        const firstCandyIdxOfType = prefixSum[candyType];
        // The last candy of `candyType` is at the position `prefixSum[candyType] + candiesCount[candyType] - 1`.
        const lastCandyIdxOfType = prefixSum[candyType] + BigInt(candiesCount[candyType]) - 1n;

        // Interval 2: [min_candy_index_eaten_by_day, max_candy_index_eaten_by_day]
        // This represents the range of 0-indexed positions for candies that could possibly be eaten by the end of `day`.

        // To eat a candy on `day` (0-indexed), you must have eaten at least `day` candies before it.
        // So, the earliest 0-indexed candy you could eat on `day` is `day`.
        // This occurs if you eat 1 candy per day from day 0 up to day `day`.
        const minIdxEatenByDay = day; 

        // The latest 0-indexed candy you could eat on `day` is if you eat `dailyCap` candies per day.
        // By the end of `day`, you would have eaten `(day + 1) * dailyCap` candies in total.
        // The last candy eaten would be at index `(day + 1) * dailyCap - 1`.
        const maxIdxEatenByDay = (day + 1n) * dailyCap - 1n;

        // Check for overlap between the two intervals:
        // Interval A: [firstCandyIdxOfType, lastCandyIdxOfType]
        // Interval B: [minIdxEatenByDay, maxIdxEatenByDay]
        // Two intervals [a, b] and [c, d] overlap if max(a, c) <= min(b, d).

        const intersectionStart = firstCandyIdxOfType > minIdxEatenByDay ? firstCandyIdxOfType : minIdxEatenByDay;
        const intersectionEnd = lastCandyIdxOfType < maxIdxEatenByDay ? lastCandyIdxOfType : maxIdxEatenByDay;

        // If intersectionStart <= intersectionEnd, there is an overlap, meaning it's possible.
        results.push(intersectionStart <= intersectionEnd);
    }

    return results;
};