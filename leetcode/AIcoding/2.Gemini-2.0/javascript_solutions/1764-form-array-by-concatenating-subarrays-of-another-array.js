var canFormArray = function(groups, nums) {
    let i = 0;
    for (let group of groups) {
        let found = false;
        while (i <= nums.length - group.length) {
            let match = true;
            for (let j = 0; j < group.length; j++) {
                if (group[j] !== nums[i + j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                i += group.length;
                found = true;
                break;
            } else {
                i++;
            }
        }
        if (!found) {
            return false;
        }
        i = 0;

        let currentNums = nums.slice();
        let currentI = 0;
        for (let currentGroup of groups){
            let groupFound = false;
            while (currentI <= currentNums.length - currentGroup.length){
                let match = true;
                for(let j = 0; j < currentGroup.length; j++){
                    if(currentGroup[j] !== currentNums[currentI+j]){
                        match = false;
                        break;
                    }
                }

                if(match){
                    currentNums = currentNums.slice(currentI + currentGroup.length);
                    currentI = 0;
                    groupFound = true;
                    break;
                } else {
                    currentI++;
                }
            }

            if(!groupFound){
                return false;
            }
        }
        return currentNums.length === 0;
    }
    return true;
};