var breakfastNumber = function(staple, drinks, x) {
    staple.sort((a, b) => a - b);
    drinks.sort((a, b) => a - b);
    let res = 0;
    let j = drinks.length - 1;
    for (let i = 0; i < staple.length; i++) {
        while (j >= 0 && staple[i] + drinks[j] > x) {
            j--;
        }
        res += j + 1;
    }
    return res % 1000000007;
};