var minSwapsCouples = function(row) {
    const n = row.length;
    const pos = new Array(n); 

    for (let i = 0; i < n; i++) {
        pos[row[i]] = i;
    }

    let swaps = 0;

    for (let i = 0; i < n; i += 2) {
        const person1 = row[i];
        const partner1 = person1 % 2 === 0 ? person1 + 1 : person1 - 1;

        if (row[i + 1] !== partner1) {
            swaps++;

            const person2 = row[i + 1]; 
            const indexOfPartner1 = pos[partner1];

            row[i + 1] = partner1;
            row[indexOfPartner1] = person2;

            pos[partner1] = i + 1;
            pos[person2] = indexOfPartner1;
        }
    }

    return swaps;
};