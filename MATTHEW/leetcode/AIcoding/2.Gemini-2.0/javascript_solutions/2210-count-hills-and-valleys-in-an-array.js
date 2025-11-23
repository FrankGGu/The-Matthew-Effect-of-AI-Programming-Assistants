var countHillValley = function(nums) {
    let count = 0;
    let arr = [];
    for(let i = 0; i < nums.length; i++){
        if(arr.length === 0 || nums[i] !== arr[arr.length - 1]){
            arr.push(nums[i]);
        }
    }

    for(let i = 1; i < arr.length - 1; i++){
        if((arr[i] > arr[i-1] && arr[i] > arr[i+1]) || (arr[i] < arr[i-1] && arr[i] < arr[i+1])){
            count++;
        }
    }

    return count;
};