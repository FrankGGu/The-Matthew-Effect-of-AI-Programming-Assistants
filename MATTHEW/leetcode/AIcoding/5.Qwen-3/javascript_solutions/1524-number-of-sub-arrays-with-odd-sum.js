function numOfSubarrays(arr) {
    let odd = 0, even = 0, result = 0, sum = 0;
    for (let i = 0; i < arr.length; i++) {
        sum += arr[i];
        if (sum % 2 === 1) {
            odd++;
            result += even + 1;
        } else {
            even++;
            result += odd;
        }
    }
    return result;
}