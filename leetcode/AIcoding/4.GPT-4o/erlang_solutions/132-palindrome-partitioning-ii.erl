{
  "id": "132",
  "title": "Palindrome Partitioning II",
  "titleSlug": "palindrome-partitioning-ii",
  "difficulty": "Hard",
  "category": "Algorithms",
  "topics": [
    "String",
    "Dynamic Programming"
  ],
  "content": "<p>Given a string <code>s</code>, partition <code>s</code> such that every <span data-keyword=\"substring-nonempty\">substring</span> of the partition is a <span data-keyword=\"palindrome-string\">palindrome</span>.</p>\n\n<p>Return <em>the <strong>minimum</strong> cuts needed for a palindrome partitioning of</em> <code>s</code>.</p>\n\n<p>&nbsp;</p>\n<p><strong class=\"example\">Example 1:</strong></p>\n\n<pre>\n<strong>Input:</strong> s = &quot;aab&quot;\n<strong>Output:</strong> 1\n<strong>Explanation:</strong> The palindrome partitioning [&quot;aa&quot;,&quot;b&quot;] could be produced using 1 cut.\n</pre>\n\n<p><strong class=\"example\">Example 2:</strong></p>\n\n<pre>\n<strong>Input:</strong> s = &quot;a&quot;\n<strong>Output:</strong> 0\n</pre>\n\n<p><strong class=\"example\">Example 3:</strong></p>\n\n<pre>\n<strong>Input:</strong> s = &quot;ab&quot;\n<strong>Output:</strong> 1\n</pre>\n\n<p>&nbsp;</p>\n<p><strong>Constraints:</strong></p>\n\n<ul>\n\t<li><code>1 &lt;= s.length &lt;= 2000</code></li>\n\t<li><code>s</code> consists of lowercase English letters only.</li>\n</ul>\n",
  "codeSnippets": {
    "cpp": "class Solution {\npublic:\n    int minCut(string s) {\n        \n    }\n};",
    "java": "class Solution {\n    public int minCut(String s) {\n        \n    }\n}",
    "python": "class Solution(object):\n    def minCut(self, s):\n        \"\"\"\n        :type s: str\n        :rtype: int\n        \"\"\"\n        ",
    "python3": "class Solution:\n    def minCut(self, s: str) -> int:\n        ",
    "c": "int minCut(char* s) {\n    \n}",
    "csharp": "public class Solution {\n    public int MinCut(string s) {\n        \n    }\n}",
    "javascript": "/**\n * @param {string} s\n * @return {number}\n */\nvar minCut = function(s) {\n    \n};",
    "typescript": "function minCut(s: string): number {\n    \n};",
    "php": "class Solution {\n\n    /**\n     * @param String $s\n     * @return Integer\n     */\n    function minCut($s) {\n        \n    }\n}",
    "swift": "class Solution {\n    func minCut(_ s: String) -> Int {\n        \n    }\n}",
    "kotlin": "class Solution {\n    fun minCut(s: String): Int {\n        \n    }\n}",
    "dart": "class Solution {\n  int minCut(String s) {\n    \n  }\n}",
    "golang": "func minCut(s string) int {\n    \n}",
    "ruby": "# @param {String} s\n# @return {Integer}\ndef min_cut(s)\n    \nend",
    "scala": "object Solution {\n    def minCut(s: String): Int = {\n        \n    }\n}",
    "rust": "impl Solution {\n    pub fn min_cut(s: String) -> i32 {\n        \n    }\n}",
    "racket": "(define/contract (min-cut s)\n  (-> string? exact-integer?)\n  )",
    "erlang": "-spec min_cut(S :: unicode:unicode_binary()) -> integer().\nmin_cut(S) ->\n  .",
    "elixir": "defmodule Solution do\n  @spec min_cut(s :: String.t) :: integer\n  def min_cut(s) do\n    \n  end\nend",
    "cangjie": "class Solution {\n    func minCut(s: String): Int64 {\n\n    }\n}"
  },
  "exampleTestcases": "\"aab\"\n\"a\"\n\"ab\"",
  "hints": []
}