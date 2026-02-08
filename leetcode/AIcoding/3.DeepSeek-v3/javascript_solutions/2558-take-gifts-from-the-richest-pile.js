var pickGifts = function(gifts, k) {
    for (let i = 0; i < k; i++) {
        let maxIndex = 0;
        for (let j = 1; j < gifts.length; j++) {
            if (gifts[j] > gifts[maxIndex]) {
                maxIndex = j;
            }
        }
        const remaining = Math.floor(Math.sqrt(gifts[maxIndex]));
        gifts[maxIndex] = remaining;
    }
    return gifts.reduce((sum, num) => sum + num, 0);
};