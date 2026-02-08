var countSeniors = function(details) {
    let count = 0;
    for (const detail of details) {
        if (parseInt(detail[detail.length - 2]) >= 60) {
            count++;
        }
    }
    return count;
};