var canPlantFlowers = function(desert, n) {
    let count = 0;
    for (let i = 0; i < desert.length; i++) {
        if (desert[i] === 0) {
            const prevEmpty = (i === 0 || desert[i - 1] === 0);
            const nextEmpty = (i === desert.length - 1 || desert[i + 1] === 0);

            if (prevEmpty && nextEmpty) {
                desert[i] = 1; // Plant a flower
                count++;
            }
        }
        if (count >= n) {
            return true;
        }
    }
    return count >= n;
};