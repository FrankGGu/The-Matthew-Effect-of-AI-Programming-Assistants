var maximizeWin = function(prizePositions, k) {
    prizePositions.sort((a, b) => a - b);
    let n = prizePositions.length;
    let max = 0;
    let left = 0;
    let counts = new Array(n).fill(0);

    for (let right = 0; right < n; right++) {
        while (prizePositions[right] - prizePositions[left] > k) {
            left++;
        }
        counts[right] = right - left + 1;
        max = Math.max(max, counts[right]);
    }

    let ans = max;
    for (let i = 0; i < n; i++) {
        let l = i + 1;
        let r = n - 1;
        let best = -1;
        while (l <= r) {
            let mid = Math.floor((l + r) / 2);
            if (prizePositions[mid] - prizePositions[i] <= k) {
                best = mid;
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        let secondMax = 0;
        if (best + 1 < n) {
            secondMax = counts[n - 1];
        }
        if (best + 1 >=0 && best +1 < n){
          secondMax = counts[n-1];
          let l2 = best+1;
          let r2=n-1;
            secondMax = 0;
            let left2 = best + 1;
            for(let right2 = best+1; right2 < n; right2++){
                while(prizePositions[right2] - prizePositions[left2] > k){
                    left2++;
                }
                secondMax = Math.max(secondMax, right2 - left2 + 1);
            }
        }

        ans = Math.max(ans, best - i + 1 + secondMax);
    }

    return ans;
};