var maxDistinctElements = function(nums, k) {
    const counts = {};
    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    const freq = Object.values(counts);
    freq.sort((a, b) => a - b);

    let distinct = freq.length;
    for (let i = 0; i < freq.length; i++) {
        if (freq[i] === 1) continue;

        const cost = freq[i] - 1;
        if (k >= cost) {
            k -= cost;
            freq[i] = 1;
        } else {
            freq[i] -= k;
            k = 0;
            break;
        }
    }

    freq.sort((a, b) => a - b);

    for (let i = 0; i < freq.length; i++) {
      if (freq[i] === 1) continue;

      if(k > 0) {
          if (k >= freq[i]) {
              k -= freq[i];
              distinct--;
          }
      }
    }

    let i = 0;
    while(i < freq.length && k > 0){
        if(freq[i] === 1){
            if(k >= 1){
                k--;
                distinct--;
            }
        }
        i++;
    }

    return distinct;
};