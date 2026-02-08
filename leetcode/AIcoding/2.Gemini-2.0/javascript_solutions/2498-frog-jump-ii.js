var maxJump = function(stones) {
    let n = stones.length;
    let maxDist = 0;
    for (let i = 0; i < n - 1; i++) {
        maxDist = Math.max(maxDist, stones[i + 1] - stones[i]);
    }
    for (let i = 1; i < n; i++) {
        maxDist = Math.max(maxDist, stones[i] - stones[i - 1]);
    }

    let left = 0;
    let right = n - 1;
    let ans = 0;
    while(left < right){
        ans = Math.max(ans, stones[right] - stones[left]);
        left++;
    }

    left = 0;
    right = n - 1;

    while(left < right){
        ans = Math.max(ans, stones[right] - stones[left]);
        right--;
    }

    let maxJumpValue = 0;
    for(let i = 0; i < stones.length - 1; i++){
        maxJumpValue = Math.max(maxJumpValue, stones[i+1] - stones[i]);
    }

    for(let i = stones.length - 1; i > 0; i--){
        maxJumpValue = Math.max(maxJumpValue, stones[i] - stones[i-1]);
    }

    ans = 0;
    for(let i = 0; i < stones.length - 1; i++){
        ans = Math.max(ans, stones[i+1] - stones[i]);
    }

    for(let i = stones.length - 1; i > 0; i--){
        ans = Math.max(ans, stones[i] - stones[i-1]);
    }

    let max1 = 0;
    for(let i = 0; i < stones.length - 1; i++){
        max1 = Math.max(max1, stones[i+1] - stones[i]);
    }
    let max2 = 0;
    for(let i = 1; i < stones.length; i++){
        max2 = Math.max(max2, stones[i] - stones[i-1]);
    }

    return Math.max(max1,max2);
};