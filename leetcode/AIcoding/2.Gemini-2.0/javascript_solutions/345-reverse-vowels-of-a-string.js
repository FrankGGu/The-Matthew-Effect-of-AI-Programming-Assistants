var reverseVowels = function(s) {
    const vowels = "aeiouAEIOU";
    let arr = s.split("");
    let left = 0;
    let right = arr.length - 1;

    while (left < right) {
        while (left < right && vowels.indexOf(arr[left]) === -1) {
            left++;
        }

        while (left < right && vowels.indexOf(arr[right]) === -1) {
            right--;
        }

        if (left < right) {
            let temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }

    return arr.join("");
};