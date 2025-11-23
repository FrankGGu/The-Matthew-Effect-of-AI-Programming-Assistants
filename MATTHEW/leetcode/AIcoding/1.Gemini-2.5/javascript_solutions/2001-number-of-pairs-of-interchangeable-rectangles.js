var interchangeableRectangles = function(rectangles) {
    const ratioCounts = new Map();
    let pairCount = 0;

    // Helper function to calculate GCD using Euclidean algorithm
    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    for (const [w, h] of rectangles) {
        // Simplify the fraction w/h by dividing by their greatest common divisor
        const commonDivisor = gcd(w, h);
        const simplifiedW = w / commonDivisor;
        const simplifiedH = h / commonDivisor;

        // Use a string representation of the simplified fraction as the map key
        const ratioKey = `${simplifiedW}/${simplifiedH}`;

        // Increment the count for this ratio
        ratioCounts.set(ratioKey, (ratioCounts.get(ratioKey) || 0) + 1);
    }

    // Calculate the number of pairs for each ratio
    for (const count of ratioCounts.values()) {
        if (count >= 2) {
            // If there are 'count' rectangles with the same ratio,
            // the number of pairs is count * (count - 1) / 2
            pairCount += (count * (count - 1)) / 2;
        }
    }

    return pairCount;
};