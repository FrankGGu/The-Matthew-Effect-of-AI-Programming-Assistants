var hIndex = function(citations) {
    citations.sort((a, b) => b - a);

    let h_index = 0;
    for (let i = 0; i < citations.length; i++) {
        let current_h = i + 1;
        if (citations[i] >= current_h) {
            h_index = current_h;
        } else {
            break;
        }
    }

    return h_index;
};