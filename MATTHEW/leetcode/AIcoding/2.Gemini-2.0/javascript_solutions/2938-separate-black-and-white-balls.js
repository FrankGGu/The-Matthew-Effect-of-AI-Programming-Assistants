var separateBalls = function(balls) {
    let count = 0;
    let zeros = 0;
    for(let i = 0; i < balls.length; i++){
        if(balls[i] === 0){
            count += i - zeros;
            zeros++;
        }
    }
    return count;
};