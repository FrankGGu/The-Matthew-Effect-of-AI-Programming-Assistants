var getTriggerTime = function(increase, requirements) {
    const n = requirements.length;
    const result = new Array(n).fill(-1);
    let current = [0, 0, 0];

    for (let i = 0; i < increase.length; i++) {
        current[0] += increase[i][0];
        current[1] += increase[i][1];
        current[2] += increase[i][2];

        for (let j = 0; j < n; j++) {
            if (result[j] === -1 && current[0] >= requirements[j][0] && current[1] >= requirements[j][1] && current[2] >= requirements[j][2]) {
                result[j] = i + 1;
            }
        }
    }

    for (let j = 0; j < n; j++) {
        if (result[j] === -1 && current[0] >= requirements[j][0] && current[1] >= requirements[j][1] && current[2] >= requirements[j][2]) {
            if (increase.length === 0 && requirements[j][0] <= 0 && requirements[j][1] <= 0 && requirements[j][2] <= 0) {
                result[j] = 0;
            }
        }
        if (result[j] === -1 && increase.length === 0 && (requirements[j][0] > 0 || requirements[j][1] > 0 || requirements[j][2] > 0)){
            result[j] = -1;
        }
    }

    for(let j = 0; j < n; j++){
        if(result[j] === -1 && requirements[j][0] <= 0 && requirements[j][1] <= 0 && requirements[j][2] <= 0){
            result[j] = 0;
        }
    }
    return result;
};