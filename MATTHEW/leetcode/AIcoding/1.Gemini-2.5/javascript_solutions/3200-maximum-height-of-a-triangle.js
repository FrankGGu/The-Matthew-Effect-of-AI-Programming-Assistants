var maxHeightOfTriangle = function(red, blue) {

    const calculateHeight = (count1, count2) => {
        let h = 0;
        let currentRed = count1;
        let currentBlue = count2;
        let k = 1;

        while (true) {
            if (k % 2 === 1) { // Odd layer, uses count1 color
                if (currentRed >= k) {
                    currentRed -= k;
                    h++;
                    k++;
                } else {
                    break;
                }
            } else { // Even layer, uses count2 color
                if (currentBlue >= k) {
                    currentBlue -= k;
                    h++;
                    k++;
                } else {
                    break;
                }
            }
        }
        return h;
    };

    // Scenario 1: Layer 1 is red, Layer 2 is blue, etc.
    const height1 = calculateHeight(red, blue);

    // Scenario 2: Layer 1 is blue, Layer 2 is red, etc.
    const height2 = calculateHeight(blue, red);

    return Math.max(height1, height2);
};