var minimumOperations = function(nums) {
    let operations = 0;
    let set = new Set();
    for(let num of nums){
        if(num > 0){
            set.add(num);
        }
    }
    return set.size;
};