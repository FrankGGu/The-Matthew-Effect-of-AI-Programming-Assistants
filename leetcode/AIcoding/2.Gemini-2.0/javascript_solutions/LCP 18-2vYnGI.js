var breakfastNumber = function(staple, drinks, x) {
    staple.sort((a, b) => a - b);
    drinks.sort((a, b) => a - b);
    let count = 0;
    let j = drinks.length - 1;
    for (let i = 0; i < staple.length; i++) {
        while (j >= 0 && staple[i] + drinks[j] > x) {
            j--;
        }
        count = (count + j + 1) % 1000000007;
    }
    return count;
};