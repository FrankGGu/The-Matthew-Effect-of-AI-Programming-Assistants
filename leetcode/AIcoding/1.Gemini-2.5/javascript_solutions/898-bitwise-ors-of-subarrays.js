var subarrayBitwiseORs = function(arr) {
    let allOrs = new Set();
    let currentOrs = new Set(); 

    for (let num of arr) {
        let newCurrentOrs = new Set();

        newCurrentOrs.add(num);

        for (let prevOr of currentOrs) {
            newCurrentOrs.add(prevOr | num);
        }

        currentOrs = newCurrentOrs;

        for (let orVal of currentOrs) {
            allOrs.add(orVal);
        }
    }

    return allOrs.size;
};