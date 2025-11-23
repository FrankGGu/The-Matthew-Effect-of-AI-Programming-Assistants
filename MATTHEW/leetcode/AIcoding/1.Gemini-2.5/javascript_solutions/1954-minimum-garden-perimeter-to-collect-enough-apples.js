var minimumPerimeter = function(neededApples) {
    let k = 1;

    while (true) {
        // The total number of apples collected within a square garden of side length 2k
        // (i.e., points (x, y) such that -k <= x <= k and -k <= y <= k)
        // can be calculated using the formula:
        // Sum_{x=-k to k} Sum_{y=-k to k} (|x| + |y|)
        // This sum can be broken down into two symmetric parts:
        // Sum_{x=-k to k} Sum_{y=-k to k} |x|  +  Sum_{x=-k to k} Sum_{y=-k to k} |y|
        // Both parts are equal. Let's calculate the first part:
        // Sum_{x=-k to k} ( (2k + 1) * |x| )  (since Sum_{y=-k to k} 1 = 2k + 1)
        // = (2k + 1) * Sum_{x=-k to k} |x|
        // Sum_{x=-k to k} |x| = 2 * Sum_{x=1 to k} x = 2 * k * (k + 1) / 2 = k * (k + 1)
        // So, the first part is (2k + 1) * k * (k + 1).
        // Doubling this for both parts gives the total apples:
        // totalApples = 2 * k * (k + 1) * (2k + 1)

        // JavaScript's `number` type (double-precision floating-point) can
        // represent integers up to 2^53 - 1 (approximately 9 * 10^15) exactly.
        // Given neededApples is up to 10^15, the maximum calculated currentApples
        // will also fit within this range, so standard numbers are sufficient.
        let currentApples = 2 * k * (k + 1) * (2 * k + 1);

        if (currentApples >= neededApples) {
            // The perimeter of a square garden of side length 2k is 8k.
            return 8 * k;
        }
        k++;
    }
};