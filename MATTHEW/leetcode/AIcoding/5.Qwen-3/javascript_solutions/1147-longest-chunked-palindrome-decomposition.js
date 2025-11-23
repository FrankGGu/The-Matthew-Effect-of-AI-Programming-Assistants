function longestDecomposition(s) {
    let left = 0, right = s.length - 1;
    let result = 0;
    let leftHash = 0, rightHash = 0;
    let base = 257;
    let mod = 1000000007;
    let power = 1;

    while (left <= right) {
        leftHash = (leftHash * base + s.charCodeAt(left)) % mod;
        rightHash = (rightHash + s.charCodeAt(right) * power) % mod;
        power = (power * base) % mod;

        if (leftHash === rightHash) {
            result++;
            leftHash = 0;
            rightHash = 0;
            power = 1;
            left++;
            right--;
        } else {
            left++;
            right--;
        }
    }

    return result;
}