var maximumRequests = function(n, requests) {
    let maxAchievableRequests = 0;
    const numRequests = requests.length;
    const balance = new Array(n).fill(0);

    function backtrack(index, currentRequestsCount) {
        if (index === numRequests) {
            let allZero = true;
            for (let i = 0; i < n; i++) {
                if (balance[i] !== 0) {
                    allZero = false;
                    break;
                }
            }
            if (allZero) {
                maxAchievableRequests = Math.max(maxAchievableRequests, currentRequestsCount);
            }
            return;
        }

        // Option 1: Don't include the current request
        backtrack(index + 1, currentRequestsCount);

        // Option 2: Include the current request
        const [from, to] = requests[index];
        balance[from]--;
        balance[to]++;
        backtrack(index + 1, currentRequestsCount + 1);
        // Backtrack: Undo the changes for the next branch
        balance[from]++;
        balance[to]--;
    }

    backtrack(0, 0);
    return maxAchievableRequests;
};