var fizzBuzz = function(n) {
    const answer = [];
    for (let i = 1; i <= n; i++) {
        const divisibleBy3 = (i % 3 === 0);
        const divisibleBy5 = (i % 5 === 0);

        if (divisibleBy3 && divisibleBy5) {
            answer.push("FizzBuzz");
        } else if (divisibleBy3) {
            answer.push("Fizz");
        } else if (divisibleBy5) {
            answer.push("Buzz");
        } else {
            answer.push(i.toString());
        }
    }
    return answer;
};