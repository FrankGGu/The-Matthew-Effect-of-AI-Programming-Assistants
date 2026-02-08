var maximizeAmount = function(amounts) {
    amounts.sort((a, b) => a - b);
    let a = amounts[0];
    let b = amounts[1];
    let c = amounts[2];

    let ans = 0;

    if (a > 0 && b > 0 && c > 0) {
        ans = Math.max(a - 1 + b - 1 + c, a + b - 1 + c - 1, a - 1 + b + c - 1);
        ans = Math.max(ans, a + b + c - 2);
    }
    else if (a <= 0 && b > 0 && c > 0) {
        ans = c + b - 1;
    }
    else if (a <= 0 && b <= 0 && c > 0){
        ans = c;
    }
    else if (a <= 0 && b <= 0 && c <= 0){
        ans = 0;
    }
    else if (a > 0 && b > 0 && c <= 0){
        ans = a + b - 1;
    }
    else if (a > 0 && b <= 0 && c > 0){
        ans = a + c - 1;
    }

    let arr = amounts.slice().sort((x,y) => y - x);
    let ans2 = arr[0] + arr[1] - 1;

    return ans2;
};