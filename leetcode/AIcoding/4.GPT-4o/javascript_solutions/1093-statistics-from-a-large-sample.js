class Solution {
    sampleStats(count) {
        let totalCount = 0;
        let min = -1;
        let max = -1;
        let sum = 0;
        let mode = -1;
        let maxCount = 0;

        for (let i = 0; i < 256; i++) {
            if (count[i] > 0) {
                totalCount += count[i];
                sum += i * count[i];
                if (min === -1) min = i;
                max = i;
                if (count[i] > maxCount) {
                    maxCount = count[i];
                    mode = i;
                }
            }
        }

        let mean = sum / totalCount;
        let median = 0;

        if (totalCount % 2 === 0) {
            let mid1 = totalCount / 2;
            let mid2 = mid1 - 1;
            let count1 = 0;
            let count2 = 0;

            for (let i = 0; i < 256; i++) {
                count1 += count[i];
                if (count1 > mid1 && count2 === 0) {
                    median += i;
                }
                if (count1 > mid2) {
                    median += i;
                    count2++;
                }
                if (count2 > 0) break;
            }
            median /= 2;
        } else {
            let mid = Math.floor(totalCount / 2);
            let countMid = 0;

            for (let i = 0; i < 256; i++) {
                countMid += count[i];
                if (countMid > mid) {
                    median = i;
                    break;
                }
            }
        }

        return [min, max, mean, median, mode];
    }
}