var solve = function(nums) {
    let n = nums.length;
    let operations = 0;
    let current = nums.slice();

    while (current.some(x => x !== 0)) {
        let indices = [];
        for (let i = 0; i < n; i++) {
            if (current[i] !== 0) {
                indices.push(i);
            }
        }

        if (indices.length === 0) break;

        operations++;
        let temp = new Array(n).fill(0);

        for (let i = 0; i < indices.length; i++) {
            let idx = indices[i];
            if (i % 2 === 0) {
                temp[idx] = current[idx];

                if(i+1 < indices.length){
                    let nextIdx = indices[i+1];
                    current[nextIdx] = current[nextIdx] ^ current[idx];

                }

            } 
        }
        current = current.map((val, index) => temp[index] === 0 ? val : 0 );

    }

    return operations;
};