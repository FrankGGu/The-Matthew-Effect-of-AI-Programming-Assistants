var commonChars = function(A) {
    let firstWord = A[0];
    let result = [];

    for (let char of firstWord) {
        let common = true;
        for (let i = 1; i < A.length; i++) {
            let index = A[i].indexOf(char);
            if (index === -1) {
                common = false;
                break;
            } else {
                A[i] = A[i].substring(0, index) + A[i].substring(index + 1);
            }
        }
        if (common) {
            result.push(char);
        }
    }

    return result;
};