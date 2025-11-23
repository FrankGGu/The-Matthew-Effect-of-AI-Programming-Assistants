var perfectMenu = function(materials, cookbooks, attribute, limit) {
    let maxDelicious = -1;
    const n = cookbooks.length;

    const backtrack = (index, currentMaterials, currentSum, currentLimit) => {
        if (currentLimit >= limit) {
            if (currentSum > maxDelicious) {
                maxDelicious = currentSum;
            }
        }

        for (let i = index; i < n; i++) {
            const needed = cookbooks[i];
            let canCook = true;
            const newMaterials = [...currentMaterials];

            for (let j = 0; j < 5; j++) {
                if (newMaterials[j] < needed[j]) {
                    canCook = false;
                    break;
                }
                newMaterials[j] -= needed[j];
            }

            if (canCook) {
                backtrack(i, newMaterials, currentSum + attribute[i][0], currentLimit + attribute[i][1]);
            }
        }
    };

    backtrack(0, [...materials], 0, 0);
    return maxDelicious;
};