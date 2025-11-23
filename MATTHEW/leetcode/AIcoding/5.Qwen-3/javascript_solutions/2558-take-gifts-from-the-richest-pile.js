function pickGifts(gifts, k) {
    for (let i = 0; i < k; i++) {
        let max = Math.max(...gifts);
        let index = gifts.indexOf(max);
        gifts[index] = Math.floor(max / 2);
    }
    return gifts;
}