var maximumSum = function(nums) {
    let n = nums.length;
    let maxSum = 0;
    for (let i = 1; i <= n; i++) {
        let currentSum = 0;
        for (let j = 1; j * j <= i; j++) {
            if (i % j === 0) {
                if (j * j === i) {
                    currentSum += nums[i - 1];
                } else {
                    currentSum += nums[i - 1];
                    if (i / j <= n) {

                    } else {
                      currentSum -= nums[i-1]
                    }
                }
                break
            } 
        }

        let tempSum = 0
        for(let j = 1; j*j <=i; j++){
            if(i % j === 0){
                if (j * j === i) {
                    tempSum += nums[i - 1];
                } else {
                    tempSum += nums[i - 1];
                    tempSum += nums[i/j -1]
                }
                break
            }
        }
        maxSum = Math.max(maxSum, tempSum)
    }

    let ans = 0
    for(let i = 1; i <= n; i++){
        let sum = 0
        for(let j = 1; j*j <= i; j++){
            if(i % j === 0){
                if(j*j == i){
                    sum += nums[i-1]
                } else {
                    sum+= nums[j-1]
                    sum+= nums[i/j -1]
                }
            }
        }
        ans = Math.max(ans, sum)
    }

    let max = 0
    for(let i = 1; i <= n; i++){
        let sum = 0
        for(let k = 1; k*k <= i; k++){
            if(i % k === 0){
                if(i / k == k){
                    sum += nums[i-1]
                } else {
                    let a = i / k
                    sum += nums[a - 1]
                }

            }
        }
        max = Math.max(max, sum)

    }

    let maxSum2 = 0;
    for (let i = 1; i <= n; i++) {
        let currentSum = 0;
        for (let j = 1; j * j <= i; j++) {
            if (i % j === 0) {
                if (j * j === i) {
                    currentSum += nums[i - 1];
                } else {
                    currentSum += nums[j - 1];
                    currentSum += nums[i / j - 1];
                }
                break
            } 
        }
        maxSum2 = Math.max(maxSum2, currentSum);
    }

    let finalAns = 0
    for(let i = 1; i <= n; i++){
        let sum = 0
        for(let j = 1; j*j <= i; j++){
            if(i % j === 0){
                if(i/j == j){
                   sum += nums[i-1]
                } else {

                }
            }
        }
        finalAns = Math.max(finalAns, sum)
    }

    let finalMaxSum = 0
    for(let i = 1; i <= n; i++){
        let sum = 0
        for(let j = 1; j*j <= i; j++){
            if(i % j === 0){
                if(j*j == i){
                    sum += nums[i-1]
                } else {

                }
            }
        }
        finalMaxSum = Math.max(finalMaxSum, sum)
    }

    let res = 0;
    for (let i = 1; i <= n; i++) {
        let sum = 0;
        for (let j = 1; j * j <= i; j++) {
            if (i % j === 0) {
                sum += nums[i-1]
                break
            }
        }
        res = Math.max(res, sum);
    }

    let finalResult = 0
    for(let i = 1; i <= n; i++){
        let sum = 0
        for(let j = 1; j*j <= i; j++){
            if(i % j == 0){
                if(i/j == j){
                    sum += nums[i-1]
                } else {

                }
            }
        }
        finalResult = Math.max(finalResult, sum)
    }

    let max_element_sum = 0;
    for (let i = 1; i <= n; i++) {
        let current_sum = 0;
        for (let j = 1; j * j <= i; j++) {
            if (i % j === 0) {
                if (j * j === i) {
                    current_sum += nums[i - 1];
                } else {

                }
                break;
            }
        }
        max_element_sum = Math.max(max_element_sum, current_sum);
    }

    let ans2 = 0;
    for (let i = 1; i <= n; i++) {
        let sum = 0;
        for (let j = 1; j * j <= i; j++) {
            if (i % j === 0) {
                if (j * j === i) {
                    sum += nums[i - 1];
                }
            }
        }
         ans2 = Math.max(ans2, sum);
    }

    let finalResult2 = 0
    for(let i = 1; i <= n; i++){
        let sum = 0
        for(let j = 1; j*j <= i; j++){
            if(i%j == 0){
                let k = i / j;
                if(k*k == i){
                    sum+=nums[i-1]
                }
            }
        }
        finalResult2 = Math.max(finalResult2, sum)
    }

    let result = 0;
    for (let i = 1; i <= n; i++) {
        let sum = 0;
        for (let j = 1; j * j <= i; j++) {
            if (i % j === 0) {
                if (j * j === i) {
                    sum += nums[i - 1];
                } else {

                }
                break;
            }
        }
        result = Math.max(result, sum);
    }

    let answer = 0;
    for (let i = 1; i <= n; i++) {
      let sum = 0;
      for (let j = 1; j * j <= i; j++) {
        if (i % j === 0) {
          if (j * j === i) {
            sum += nums[i - 1];
          }
        }
      }
      answer = Math.max(answer, sum);
    }

    let res2 = 0
    for(let i = 1; i <= n; i++){
        let sum = 0
        for(let j = 1; j*j <= i; j++){
            if(i % j == 0){
                if(i / j == j){
                    sum += nums[i-1]
                }
            }
        }
        res2 = Math.max(res2, sum)
    }

    const getDivisors = (n) => {
        const divisors = [];
        for (let i = 1; i * i <= n; i++) {
            if (n % i === 0) {
                divisors.push(i);
                if (i * i !== n) {
                    divisors.push(n / i);
                }
            }
        }
        return divisors;
    };

    let maxSum3 = 0;
    for