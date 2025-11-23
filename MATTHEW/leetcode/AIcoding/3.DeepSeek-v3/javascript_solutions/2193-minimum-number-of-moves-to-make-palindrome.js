var minMovesToMakePalindrome = function(s) {
    let res = 0;
    let arr = s.split('');
    while (arr.length > 0) {
        let i = arr.indexOf(arr[arr.length - 1]);
        if (i === arr.length - 1) {
            res += Math.floor(i / 2);
        } else {
            res += i;
            arr.splice(i, 1);
        }
        arr.pop();
    }
    return res;
};