var commonChars = function(A) {
    let result = A[0].split('');
    for (let i = 1; i < A.length; i++) {
        let temp = [];
        let count = {};
        for (let char of A[i]) {
            count[char] = (count[char] || 0) + 1;
        }
        for (let char of result) {
            if (count[char]) {
                temp.push(char);
                count[char]--;
            }
        }
        result = temp;
    }
    return result;
};