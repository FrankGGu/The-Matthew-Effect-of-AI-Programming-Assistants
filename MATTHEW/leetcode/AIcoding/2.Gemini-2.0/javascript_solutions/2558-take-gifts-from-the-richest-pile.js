var pickGifts = function(gifts, k) {
    for (let i = 0; i < k; i++) {
        let maxIndex = 0;
        for (let j = 1; j < gifts.length; j++) {
            if (gifts[j] > gifts[maxIndex]) {
                maxIndex = j;
            }
        }
        gifts[maxIndex] = Math.floor(Math.sqrt(gifts[maxIndex]));
    }

    let sum = 0;
    for (let gift of gifts) {
        sum += gift;
    }

    return sum;
};