var maximumRequests = function(n, requests) {
    let maxRequests = 0;
    for (let i = 0; i < (1 << requests.length); i++) {
        let count = 0;
        let balance = new Array(n).fill(0);
        for (let j = 0; j < requests.length; j++) {
            if ((i >> j) & 1) {
                balance[requests[j][0]]--;
                balance[requests[j][1]]++;
                count++;
            }
        }
        let valid = true;
        for (let k = 0; k < n; k++) {
            if (balance[k] !== 0) {
                valid = false;
                break;
            }
        }
        if (valid) {
            maxRequests = Math.max(maxRequests, count);
        }
    }
    return maxRequests;
};