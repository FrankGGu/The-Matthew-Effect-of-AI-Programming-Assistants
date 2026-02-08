var kthSmallestProduct = function(nums1, nums2, k) {

    const countProductsLessThanOrEqualTo = (val) => {
        let count = 0;
        for (const num1 of nums1) {
            if (num1 === 0) {
                if (val >= 0) {
                    count += nums2.length;
                }
            } else if (num1 > 0) {
                // We need num2 * num1 <= val  =>  num2 <= val / num1
                let low = 0, high = nums2.length - 1, currentCount = 0;
                while (low <= high) {
                    let mid = Math.floor((low + high) / 2);
                    if (nums2[mid] * num1 <= val) {
                        currentCount = mid + 1;
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
                count += currentCount;
            } else { // num1 < 0
                // We need num2 * num1 <= val  =>  num2 >= val / num1 (inequality flips)
                let low = 0, high = nums2.length - 1;
                let first_idx_satisfying = nums2.length; 
                while (low <= high) {
                    let mid = Math.floor((low + high) / 2);
                    if (nums2[mid] * num1 <= val) {
                        first_idx_satisfying = mid;
                        high = mid - 1;
                    } else {
                        low = mid + 1;
                    }
                }
                count += (nums2.length - first_idx_satisfying);
            }
        }
        return count;
    };

    let low = -10000000000 - 1; 
    let high = 10000000000 + 1;  
    let ans = high; 

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        if (countProductsLessThanOrEqualTo(mid) >= k) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};